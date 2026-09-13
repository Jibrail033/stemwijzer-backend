const idPattern = /^[1-9]\d*$/u;

export function parseId(raw: string): number | undefined {
  if (!idPattern.test(raw)) {
    return undefined;
  }

  const id = Number(raw);

  return Number.isSafeInteger(id) ? id : undefined;
}
