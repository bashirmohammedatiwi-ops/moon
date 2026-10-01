import { Injectable, NotFoundException } from "@nestjs/common";
import { PrismaService } from "../../common/prisma.service";
import { CmsBilingualService } from "../../common/cms-bilingual.service";

@Injectable()
export class SpotlightService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly cmsBilingual: CmsBilingualService,
  ) {}

  private isScheduledActive(row: {
    isActive: boolean;
    startsAt: Date | null;
    endsAt: Date | null;
  }) {
    if (!row.isActive) return false;
    const now = new Date();
    if (row.startsAt && row.startsAt > now) return false;
    if (row.endsAt && row.endsAt < now) return false;
    return true;
  }

  list(activeOnly = false) {
    return this.prisma.spotlightItem.findMany({
      where: activeOnly ? { isActive: true } : undefined,
      orderBy: { position: "asc" },
      include: { image: true },
    }).then((rows) =>
      activeOnly ? rows.filter((r) => this.isScheduledActive(r)) : rows,
    );
  }

  async create(data: any) {
    const enriched = await this.cmsBilingual.enrichBannerData(data);
    return this.prisma.spotlightItem.create({ data: enriched as any, include: { image: true } });
  }

  async update(id: string, data: any) {
    const existing = await this.ensure(id);
    const enriched = await this.cmsBilingual.enrichBannerData({ ...existing, ...data });
    const patch: Record<string, unknown> = { ...data };
    for (const field of ["title", "subtitle", "badge", "ctaLabel"] as const) {
      const enKey = `${field}En`;
      if (enriched[enKey] !== undefined) patch[enKey] = enriched[enKey];
    }
    return this.prisma.spotlightItem.update({
      where: { id },
      data: patch,
      include: { image: true },
    });
  }

  async remove(id: string) {
    await this.ensure(id);
    await this.prisma.spotlightItem.delete({ where: { id } });
    return { success: true };
  }

  private async ensure(id: string) {
    const row = await this.prisma.spotlightItem.findUnique({ where: { id } });
    if (!row) throw new NotFoundException("Spotlight item not found");
    return row;
  }
}
