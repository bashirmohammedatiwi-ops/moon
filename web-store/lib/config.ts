export const APP_DOMAIN = "187.127.88.146:3200";
export const APP_ORIGIN = `http://${APP_DOMAIN}`;
export const STORE_NAME_AR = "قمر الزمان";
export const STORE_NAME_EN = "Qamar Al-Zaman";

export const API_BASE = process.env.NEXT_PUBLIC_API_BASE ?? "/api/v1";
export const MEDIA_BASE =
  process.env.NEXT_PUBLIC_MEDIA_BASE?.replace(/\/$/, "") ?? "/media";

export function displayStoreName(lang: "ar" | "en" = "ar") {
  return lang === "ar" ? STORE_NAME_AR : STORE_NAME_EN;
}
