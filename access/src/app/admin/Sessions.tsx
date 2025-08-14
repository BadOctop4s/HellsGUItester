"use client";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabaseClient";

type Session = {
  id: string;
  username: string;
  server_id: string;
  is_admin: boolean;
  last_seen: string;
};

export default function SessionsPage() {
  const [sessions, setSessions] = useState<Session[]>([]);

  useEffect(() => {
    fetchSessions();
    const channel = supabase
      .channel("sessions")
      .on("postgres_changes", { event: "*", schema: "public", table: "sessions" }, fetchSessions)
      .subscribe();
    return () => supabase.removeChannel(channel);
  }, []);

  const fetchSessions = async () => {
    const { data } = await supabase.from("sessions").select("*");
    if (data) setSessions(data);
  };

  return (
    <div>
      <h1 className="text-xl font-bold mb-4">Online Now</h1>
      <ul>
        {sessions.map((s) => (
          <li key={s.id} className="border p-2 mb-2">
            {s.username} - {s.server_id} {s.is_admin ? "(Admin)" : ""}
          </li>
        ))}
      </ul>
    </div>
  );
}
