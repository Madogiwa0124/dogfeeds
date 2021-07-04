export function getIdFromUrl(): string {
  const pathes = window.location.pathname.split("/").filter(Boolean);
  return pathes[pathes.length - 1];
}
