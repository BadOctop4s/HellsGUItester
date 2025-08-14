"use client"

import Link from 'next/link'

export default function Home() {
  return (
    <div style={{ padding: '50px', fontFamily: 'Arial, sans-serif', textAlign: 'center', background: '#f5f5f5', minHeight: '100vh' }}>
      <h1 style={{ fontSize: '3rem', marginBottom: '20px', color: '#333' }}>RoyalHub</h1>
      <p style={{ fontSize: '1.2rem', color: '#555', marginBottom: '40px' }}>
        Painel de controle completo para administradores do seu script Roblox.
      </p>

      <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap' }}>
        <Link href="/login" style={{ textDecoration: 'none' }}>
          <div style={{
            background: '#315dff',
            color: '#fff',
            padding: '30px 50px',
            borderRadius: '12px',
            boxShadow: '0 4px 12px rgba(0,0,0,0.1)',
            fontSize: '1.2rem',
            cursor: 'pointer',
            transition: 'all 0.2s'
          }}
          onMouseOver={e => (e.currentTarget.style.transform = 'translateY(-5px)')}
          onMouseOut={e => (e.currentTarget.style.transform = 'translateY(0)')}
          >
            Login Admin
          </div>
        </Link>

        <Link href="/admin" style={{ textDecoration: 'none' }}>
          <div style={{
            background: '#00c896',
            color: '#fff',
            padding: '30px 50px',
            borderRadius: '12px',
            boxShadow: '0 4px 12px rgba(0,0,0,0.1)',
            fontSize: '1.2rem',
            cursor: 'pointer',
            transition: 'all 0.2s'
          }}
          onMouseOver={e => (e.currentTarget.style.transform = 'translateY(-5px)')}
          onMouseOut={e => (e.currentTarget.style.transform = 'translateY(0)')}
          >
            Acessar Painel
          </div>
        </Link>
      </div>

      <footer style={{ marginTop: '50px', color: '#888' }}>
        &copy; 2025 RoyalHub. Todos os direitos reservados.
      </footer>
    </div>
  )
}
