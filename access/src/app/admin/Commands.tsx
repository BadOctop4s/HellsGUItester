"use client";
import { useState } from "react";
import { supabase } from "@/lib/";

export default function CommandsPage() {
  const [serverId, setServerId] = useState("");
  const [action, setAction] = useState("");
  const [payload, setPayload] = useState("");

  const sendCommand = async () => {
    if (!serverId || !action) return alert("Preencha todos os campos");
    await supabase.from("commands").insert([{ server_id: serverId, action, payload }]);
    setServerId("");
    setAction("");
    setPayload("");
    alert("Comando enviado!");
  };

  return (
    <div>
      <h1 className="text-xl font-bold mb-4">Send Command</h1>
      <div className="flex gap-2 mb-4">
        <input
          className="border p-2"
          placeholder="Server ID"
          value={serverId}
          onChange={(e) => setServerId(e.target.value)}
        />
        <input
          className="border p-2"
          placeholder="Action"
          value={action}
          onChange={(e) => setAction(e.target.value)}
        />
        <input
          className="border p-2"
          placeholder="Payload"
          value={payload}
          onChange={(e) => setPayload(e.target.value)}
        />
        <button className="bg-blue-500 text-white px-3 py-1 rounded" onClick={sendCommand}>
          Send
        </button>
      </div>
    </div>
  );
}
