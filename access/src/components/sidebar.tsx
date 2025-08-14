import Link from "next/link";

export default function Sidebar() {
  return (
    <aside className="w-64 bg-white p-4 shadow-md">
      <h2 className="text-xl font-bold mb-4">Painel Admin</h2>
      <nav className="flex flex-col gap-2">
        <Link className="hover:bg-gray-200 p-2 rounded" href="/admin/users">
          Users
        </Link>
        <Link className="hover:bg-gray-200 p-2 rounded" href="/admin/sessions">
          Online Now
        </Link>
        <Link className="hover:bg-gray-200 p-2 rounded" href="/admin/commands">
          Commands
        </Link>
      </nav>
    </aside>
  );
}
