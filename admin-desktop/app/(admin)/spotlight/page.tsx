"use client";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import {
  Alert,
  Button,
  Card,
  Form,
  Input,
  InputNumber,
  Modal,
  Popconfirm,
  Space,
  Switch,
  Table,
  Tag,
  message,
} from "antd";
import { useState } from "react";
import { BannerExtraFields } from "@/components/home-builder/SectionPayloadEditor";
import { mediaThumb } from "@/lib/mediaUrl";
import { mutations, queries } from "@/lib/queries";

function toFormValues(row: any) {
  if (!row) return { isActive: true, position: 0 };
  return {
    title: row.title,
    titleEn: row.titleEn,
    subtitle: row.subtitle,
    subtitleEn: row.subtitleEn,
    badge: row.badge,
    badgeEn: row.badgeEn,
    ctaLabel: row.ctaLabel,
    ctaLabelEn: row.ctaLabelEn,
    link: row.link ?? "",
    linkType: row.linkType,
    linkValue: row.linkValue,
    imageId: row.imageId ?? row.image?.id,
    position: row.position,
    isActive: row.isActive,
    startsAt: row.startsAt,
    endsAt: row.endsAt,
  };
}

function toPayload(values: any) {
  return {
    title: values.title,
    titleEn: values.titleEn,
    subtitle: values.subtitle,
    subtitleEn: values.subtitleEn,
    badge: values.badge ?? undefined,
    badgeEn: values.badgeEn ?? undefined,
    ctaLabel: values.ctaLabel ?? undefined,
    ctaLabelEn: values.ctaLabelEn ?? undefined,
    link: values.link ?? undefined,
    linkType: values.linkType ?? undefined,
    linkValue: values.linkValue ?? undefined,
    imageId: values.imageId ?? undefined,
    position: values.position,
    isActive: values.isActive,
    startsAt: values.startsAt,
    endsAt: values.endsAt,
  };
}

export default function SpotlightPage() {
  const { data, isLoading } = useQuery({
    queryKey: ["spotlight"],
    queryFn: queries.spotlight,
  });
  const { data: categories } = useQuery({ queryKey: ["categories"], queryFn: queries.categoriesFull });
  const { data: subcategories } = useQuery({ queryKey: ["subcategories-all"], queryFn: () => queries.subcategories() });
  const { data: tertiary } = useQuery({ queryKey: ["tertiary-all"], queryFn: () => queries.tertiarySections() });
  const { data: brands } = useQuery({ queryKey: ["brands"], queryFn: () => queries.brands() });
  const { data: products } = useQuery({
    queryKey: ["products-lite-spotlight"],
    queryFn: () => queries.products({ limit: 200 }),
  });
  const entities = {
    categories: categories ?? [],
    subcategories: subcategories ?? [],
    tertiary: tertiary ?? [],
    brands: brands ?? [],
    products: products?.data ?? [],
  };
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<any | null>(null);
  const [form] = Form.useForm();

  const upsert = useMutation({
    mutationFn: async (values: any) => {
      const payload = toPayload(values);
      return editing?.id
        ? mutations.updateSpotlight(editing.id, payload)
        : mutations.createSpotlight(payload);
    },
    onSuccess: () => {
      message.success(editing ? "تم التحديث" : "تم الإنشاء");
      setOpen(false);
      qc.invalidateQueries({ queryKey: ["spotlight"] });
    },
    onError: () => message.error("تعذر حفظ العنصر"),
  });

  const remove = useMutation({
    mutationFn: mutations.deleteSpotlight,
    onSuccess: () => {
      message.success("تم الحذف");
      qc.invalidateQueries({ queryKey: ["spotlight"] });
    },
  });

  return (
    <>
      <Space direction="vertical" size={12} style={{ width: "100%" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 12 }}>
          <div>
            <h2 style={{ margin: 0 }}>سبوت لايت — صور عمودية</h2>
            <p style={{ margin: "6px 0 0", color: "#667", maxWidth: 720 }}>
              صور دعائية عمودية (9:16) تظهر في تبويب «سبوت» بالتطبيق — مثل ريلز إنستغرام.
              يُفضّل رفع صورة Portrait بجودة عالية.
            </p>
          </div>
          <Button
            type="primary"
            onClick={() => {
              setEditing(null);
              form.resetFields();
              form.setFieldsValue({ isActive: true, position: 0, ctaLabel: "اكتشفي المزيد", ctaLabelEn: "Discover" });
              setOpen(true);
            }}
          >
            + صورة جديدة
          </Button>
        </div>

        <Alert
          type="info"
          showIcon
          message="نصيحة"
          description="ارفع صورة عمودية 1080×1920 أو أقرب نسبة 9:16. اربط الصورة بمنتج، براند، قسم، أو صفحة العروض."
        />

        <Card styles={{ body: { padding: 0 } }}>
          <Table
            rowKey="id"
            loading={isLoading}
            dataSource={data ?? []}
            columns={[
              {
                title: "الصورة",
                width: 72,
                render: (_: any, r: any) => {
                  const url = mediaThumb(r.image);
                  return (
                    <div
                      style={{
                        width: 44,
                        height: 72,
                        borderRadius: 8,
                        background: url ? `center/cover url(${url})` : "#f0f0f5",
                      }}
                    />
                  );
                },
              },
              { title: "العنوان", dataIndex: "title" },
              { title: "الوسم", dataIndex: "badge", width: 120 },
              { title: "الترتيب", dataIndex: "position", width: 90 },
              {
                title: "الحالة",
                dataIndex: "isActive",
                width: 90,
                render: (v) => <Tag color={v ? "green" : "red"}>{v ? "نشط" : "مخفي"}</Tag>,
              },
              {
                title: "إجراءات",
                width: 180,
                render: (_: any, r: any) => (
                  <Space>
                    <Button
                      size="small"
                      onClick={() => {
                        setEditing(r);
                        form.setFieldsValue(toFormValues(r));
                        setOpen(true);
                      }}
                    >
                      تعديل
                    </Button>
                    <Popconfirm title="حذف؟" okText="حذف" cancelText="إلغاء" onConfirm={() => remove.mutate(r.id)}>
                      <Button danger size="small">
                        حذف
                      </Button>
                    </Popconfirm>
                  </Space>
                ),
              },
            ]}
          />
        </Card>
      </Space>

      <Modal
        title={editing ? "تعديل سبوت" : "سبوت جديد"}
        open={open}
        onCancel={() => setOpen(false)}
        onOk={() => form.submit()}
        confirmLoading={upsert.isPending}
        okText="حفظ"
        cancelText="إلغاء"
        destroyOnHidden
        width={560}
      >
        <Form layout="vertical" form={form} onFinish={(v) => upsert.mutate(v)}>
          <Form.Item name="title" label="العنوان (عربي)" rules={[{ required: true }]}>
            <Input />
          </Form.Item>
          <Form.Item name="titleEn" label="العنوان (إنجليزي)">
            <Input />
          </Form.Item>
          <Form.Item name="subtitle" label="وصف قصير (عربي)">
            <Input.TextArea rows={2} />
          </Form.Item>
          <Form.Item name="subtitleEn" label="وصف قصير (إنجليزي)">
            <Input.TextArea rows={2} />
          </Form.Item>
          <Form.Item name="badge" label="وسم (عربي)">
            <Input placeholder="جديد / حصري" />
          </Form.Item>
          <Form.Item name="badgeEn" label="وسم (إنجليزي)">
            <Input placeholder="New / Exclusive" />
          </Form.Item>
          <Form.Item name="ctaLabel" label="نص الزر (عربي)">
            <Input />
          </Form.Item>
          <Form.Item name="ctaLabelEn" label="نص الزر (إنجليزي)">
            <Input />
          </Form.Item>
          <Form.Item name="link" label="رابط احتياطي">
            <Input placeholder="/offers" />
          </Form.Item>
          <BannerExtraFields entities={entities} />
          <Form.Item name="position" label="الترتيب">
            <InputNumber style={{ width: "100%" }} min={0} />
          </Form.Item>
          <Form.Item name="isActive" label="نشط" valuePropName="checked">
            <Switch />
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
}
