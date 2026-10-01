import type { Metadata } from "next";

import { LegalDocument } from "@/components/legal/LegalDocument";
import { legalPageCopy, termsSections } from "@/lib/legal";

const copy = legalPageCopy.terms.ar;

export const metadata: Metadata = {
  title: copy.title,
  description: copy.description,
  alternates: {
    languages: {
      ar: "/terms/",
      en: "/en/terms/",
    },
  },
};

export default function TermsPage() {
  return <LegalDocument lang="ar" variant="terms" sections={termsSections.ar} />;
}
