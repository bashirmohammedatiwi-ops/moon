import { Type } from "class-transformer";
import {
  IsBoolean,
  IsDateString,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
} from "class-validator";

export class CreateSpotlightDto {
  @IsString() @IsNotEmpty() title: string;
  @IsOptional() @IsString() titleEn?: string;
  @IsOptional() @IsString() subtitle?: string;
  @IsOptional() @IsString() subtitleEn?: string;
  @IsOptional() @IsString() badge?: string;
  @IsOptional() @IsString() badgeEn?: string;
  @IsOptional() @IsString() ctaLabel?: string;
  @IsOptional() @IsString() ctaLabelEn?: string;
  @IsOptional() @IsString() link?: string;
  @IsOptional() @IsString() linkType?: string;
  @IsOptional() @IsString() linkValue?: string;
  @IsOptional() @IsString() imageId?: string;
  @IsOptional() @Type(() => Number) @IsInt() @Min(0) position?: number;
  @IsOptional() @IsBoolean() isActive?: boolean;
  @IsOptional() @IsDateString() startsAt?: string;
  @IsOptional() @IsDateString() endsAt?: string;
}

export class UpdateSpotlightDto extends CreateSpotlightDto {}
