"use client"
import { useState } from 'react'
import { supabase } from '@/lib/supabase'
import { useRouter } from 'next/navigation'

export default function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const router = useRouter()

  const handleLogin = async () => {
    const { data: user, error } = await supabase
      .from('admin_users')
      .select('*')
      .eq('email', email.trim())
      .single()

    if (error) {
      alert('Erro ao conectar com Supabase')
      console.log(error)
      return
    }

    if (!user || !user.password) {
      alert('Email ou senha incorretos')
      return
    }

    if (user.password.trim() === password.trim()) {
      localStorage.setItem('admin_email', user.email)
      router.push('/admin')
    } else {
      alert('Email ou senha incorretos')
    }
  }

  return (
    <div style={{ padding: 50, maxWidth: 400, margin: 'auto' }}>
      <h1>Login Admin</h1>
      <input
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
      />
      <input
        placeholder="Senha"
        type="password"
        value={password}
        onChange={e => setPassword(e.target.value)}
      />
      <button onClick={handleLogin}>Entrar</button>
    </div>
  )
}
