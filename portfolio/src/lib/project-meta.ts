export interface ProjectMeta {
  started: number;
  ended?: number;
  team: number;
}

/** "2024–2025", "2025", or "2026–now" for a project still running. */
export function projectPeriod(meta: ProjectMeta): string {
  if (!meta.ended) return `${meta.started}–now`;
  return meta.ended === meta.started ? String(meta.started) : `${meta.started}–${meta.ended}`;
}

export function teamLabel(team: number): string {
  return team <= 1 ? 'Solo' : `Team of ${team}`;
}

/** One line for index rows and case-study headers. */
export function projectContext(meta: ProjectMeta): string {
  return `${projectPeriod(meta)} · ${teamLabel(meta.team)}`;
}
