import { redirect } from 'next/navigation'

export default function Home() {
  redirect('/login')
}
// This file is intentionally left empty. It redirects to the login page.
// The actual content is handled in the login page, which is located at /login.