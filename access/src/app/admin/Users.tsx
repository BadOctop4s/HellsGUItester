"use client";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabaseClient";

type User = { id: string; username: string; banned: boolean };

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    const { data } = await supabase.from("users").select("*");
    if (data) setUsers(data);
  };

  const addUser = async () => {
    if (!username || !email) return alert("Preencha todos os campos");
    await supabase.from("users").insert([{ username, email, banned: false }]);
    fetchUsers();
  };

  const toggleBan = async (user: User) => {
    await supabase.from("users").update({ banned: !user.banned }).eq("id", user.id);
    fetchUsers();
  };

  return (
    <div>
      <h1 className="text-xl font-bold mb-4">Users</h1>
      <div className="flex gap-2 mb-4">
        <input
          className="border p-2"
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          className="border p-2"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <button className="bg-green-500 text-white px-3 py-1 rounded" onClick={addUser}>
          Add
        </button>
      </div>
      <ul>
        {users.map((u) => (
          <li key={u.id} className="flex justify-between mb-2">
            {u.username} ({u.banned ? "Banned" : "Active"})
            <button
              className="bg-red-500 text-white px-2 py-1 rounded"
              onClick={() => toggleBan(u)}
            >
              {u.banned ? "Unban" : "Ban"}
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
