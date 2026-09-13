export const FONT_SCALE_MIN = 10;
export const FONT_SCALE_MAX = 64;
export const FONT_SCALE_STEP = 1;
export const DEFAULT_FONT_SCALE = 21;

const legacyFontScaleValues: Record<string, number> = {
  small: 19,
  normal: DEFAULT_FONT_SCALE,
  large: 26,
  xlarge: 31,
};

const clampFontScale = (fontScale: number): number =>
  Math.min(FONT_SCALE_MAX, Math.max(FONT_SCALE_MIN, Math.round(fontScale)));

export const normalizeFontScale = (value: unknown, fallback = DEFAULT_FONT_SCALE): number => {
  if (typeof value === 'string') {
    const legacyValue = legacyFontScaleValues[value];
    if (legacyValue !== undefined) return legacyValue;

    const numericValue = Number(value);
    return Number.isFinite(numericValue) ? clampFontScale(numericValue) : clampFontScale(fallback);
  }

  if (typeof value === 'number' && Number.isFinite(value)) return clampFontScale(value);

  return clampFontScale(fallback);
};

export const formatFontScale = (fontScale: number): string => `${normalizeFontScale(fontScale)} px`;
