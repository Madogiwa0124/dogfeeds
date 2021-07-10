export function truncate(value: string, limit: number): string {
  if (value.length <= limit) return value;
  return `${value.trim().replace(/\s+/g, "").substring(0, limit)}…`;
}
