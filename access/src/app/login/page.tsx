"use client";

import { useState } from "react";
import { supabase } from "@/lib/supabaseClient"; // Ensure this path is correct
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const router = useRouter();

  const handleLogin = async () => {
    const { data: user, error } = await supabase
      .from("admin_users")
      .select("*")
      .eq("email", email)
      .single();

    if (error) return alert("Erro ao conectar com Supabase");

    if (!user) return alert("Email não encontrado");
    if (!user.password) return alert("Senha não definida");

    if (user.password === password) {
      router.push("/admin");
    } else {
      alert("Senha incorreta!");
    }
  };

  return (
    <div className="p-10 max-w-md mx-auto">
      <h1 className="text-2xl font-bold mb-4">Login Admin</h1>
      <input
        className="border p-2 w-full mb-2"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <input
        className="border p-2 w-full mb-2"
        placeholder="Senha"
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button
        className="bg-blue-500 text-white px-4 py-2 rounded"
        onClick={handleLogin}
      >
        Entrar
      </button>
    </div>
  );
}
