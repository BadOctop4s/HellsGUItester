"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabaseClient";

type SessionInfo = {
  id: string;
  user_id: string;
  ip_address?: string;
  created_at: string;
};

export default function Sessions() {
  const [sessions, setSessions] = useState<SessionInfo[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let active = true; // controla desmontagem

    const fetchSessions = async () => {
      try {
        setLoading(true);
        const { data, error } = await supabase
          .from("sessions") // tabela do supabase
          .select("*")
          .order("created_at", { ascending: false });

        if (error) {
          console.error("Erro ao buscar sessões:", error.message);
        } else if (active && data) {
          setSessions(data as SessionInfo[]);
        }
      } finally {
        if (active) setLoading(false);
      }
    };

    fetchSessions();

    // cleanup (não pode ser async)
    return () => {
      active = false;
    };
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-xl font-bold mb-4">Sessões Ativas</h1>

      {loading ? (
        <p>Carregando...</p>
      ) : sessions.length === 0 ? (
        <p>Nenhuma sessão encontrada.</p>
      ) : (
        <ul className="space-y-2">
          {sessions.map((session) => (
            <li
              key={session.id}
              className="p-3 bg-gray-100 rounded-md flex justify-between"
            >
              <span>
                Usuário: {session.user_id} — Criado em:{" "}
                {new Date(session.created_at).toLocaleString()}
              </span>
              <span>{session.ip_address || "IP não informado"}</span>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
