"use client"

import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"

// Definição do tipo User conforme a tabela do Supabase
interface User {
  id: number
  username: string
  email: string
  active: boolean
}

export default function UserList() {
  const [users, setUsers] = useState<User[]>([])
  const [username, setUsername] = useState("")
  const [email, setEmail] = useState("")
  const [active, setActive] = useState(true)

  // Função para buscar todos os usuários
  useEffect(() => {
    const fetchUsers = async () => {
      const { data, error } = await supabase.from("users").select("*")
      if (error) {
        console.error("Erro ao buscar usuários:", error)
      } else if (data) {
        // Garantindo que data seja do tipo User[]
        setUsers(data as User[])
      }
    }
    fetchUsers()
  }, [])

  // Função para adicionar novo usuário
  const addUser = async () => {
    if (!username || !email) {
      alert("Preencha username e email")
      return
    }

    const newUser = { username, email, active }

    const { data, error } = await supabase
      .from("users")
      .insert([newUser])
      .select() // retorna o objeto inserido

    if (error) {
      console.error("Erro ao adicionar usuário:", error)
    } else if (data) {
      setUsers([...users, ...data as User[]])
      setUsername("")
      setEmail("")
      setActive(true)
    }
  }

  // Função para remover usuário
  const removeUser = async (id: number) => {
    const { error } = await supabase.from("users").delete().eq("id", id)
    if (error) {
      console.error("Erro ao remover usuário:", error)
    } else {
      setUsers(users.filter(u => u.id !== id))
    }
  }

  return (
    <div>
      <h2>Usuários</h2>

      <div style={{ marginBottom: 10 }}>
        <input
          placeholder="Username"
          value={username}
          onChange={e => setUsername(e.target.value)}
        />
        <input
          placeholder="Email"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />
        <label>
          Ativo:
          <input
            type="checkbox"
            checked={active}
            onChange={e => setActive(e.target.checked)}
          />
        </label>
        <button onClick={addUser}>Adicionar Usuário</button>
      </div>

      <ul>
        {users.map(u => (
          <li key={u.id}>
            {u.username} ({u.email}) - {u.active ? "Ativo" : "Inativo"}
            <button onClick={() => removeUser(u.id)}>Remover</button>
          </li>
        ))}
      </ul>
    </div>
  )
}
