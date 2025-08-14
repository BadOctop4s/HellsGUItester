"use client"
import { useState } from 'react'
import { supabase } from '../../../lib/supabase'
import { useRouter } from 'next/navigation'

export default function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const router = useRouter()

  const handleLogin = async () => {
    const { data } = await supabase
      .from('admin_users')
      .select('*')
      .eq('email', email)
      .eq('password', password)
      .single()

    if (data) {
      alert('Login sucesso!')
      router.push('/admin')
    } else {
      alert('Email ou senha inválido!')
    }
  }

  return (
    <div style={{ padding: 50 }}>
      <h1>Login Admin</h1>
      <input placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
      <input placeholder="Senha" type="password" value={password} onChange={e => setPassword(e.target.value)} />
      <button onClick={handleLogin}>Entrar</button>
    </div>
  )
}
