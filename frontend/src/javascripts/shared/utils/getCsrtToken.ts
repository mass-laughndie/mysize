const $ = require('jquery');

export default function getCsrfToken(): string {
  const token = $('meta[name="csrf-token"]').attr('content');

  if (!token) {
    throw new Error('CSRF Token is not set. Check meta[name="csrf-token"]');
  }
  return token;
}
