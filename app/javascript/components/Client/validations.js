export const checked = (value) => {
  return value ? undefined: 'Checked';
}

export const email = (value) => {
  const email_regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;

  return (
    value && (!email_regex.test(value) ? 'Invalid email address' : undefined)
  );
}

export const emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
