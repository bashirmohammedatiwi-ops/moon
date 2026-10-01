-- CreateTable
CREATE TABLE "SpotlightItem" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "titleEn" TEXT,
    "subtitle" TEXT,
    "subtitleEn" TEXT,
    "badge" TEXT,
    "badgeEn" TEXT,
    "ctaLabel" TEXT,
    "ctaLabelEn" TEXT,
    "link" TEXT,
    "linkType" TEXT,
    "linkValue" TEXT,
    "imageId" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "startsAt" TIMESTAMP(3),
    "endsAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpotlightItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpotlightItem_isActive_idx" ON "SpotlightItem"("isActive");

-- CreateIndex
CREATE INDEX "SpotlightItem_position_idx" ON "SpotlightItem"("position");

-- AddForeignKey
ALTER TABLE "SpotlightItem" ADD CONSTRAINT "SpotlightItem_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "Media"("id") ON DELETE SET NULL ON UPDATE CASCADE;
