-- ============================================================
-- FSISMA — Script SQL completo para Supabase
-- Pegá esto en Supabase → SQL Editor → New query → Run
-- ============================================================

-- 1. EMPLEADOS
create table if not exists employees (
  id uuid primary key default gen_random_uuid(),
  dni text unique not null,
  legajo text unique not null,
  nombre text not null,
  apellido text not null,
  email text unique not null,
  sede text check (sede in ('Olivos', 'Parque Patricios')),
  campana text,
  activo boolean default true,
  created_at timestamptz default now()
);

-- 2. RECIBOS
create table if not exists recibos (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid references employees(id) on delete cascade,
  periodo_mes int check (periodo_mes between 1 and 12),
  periodo_anio int not null,
  url_pdf text not null,
  estado text default 'pendiente' check (estado in ('pendiente', 'firmado', 'disconforme')),
  observacion text,
  fecha_publicacion timestamptz default now(),
  fecha_firma timestamptz
);

-- 3. ADMINS
create table if not exists admins (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  nombre text not null,
  rol text default 'rrhh' check (rol in ('superadmin', 'rrhh')),
  created_at timestamptz default now()
);

-- 4. NOTIFICACIONES
create table if not exists notifications (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid references employees(id) on delete cascade,
  recibo_id uuid references recibos(id) on delete cascade,
  leida boolean default false,
  fecha timestamptz default now()
);

-- 5. ROW LEVEL SECURITY (RLS) — importante para seguridad

-- Habilitar RLS en todas las tablas
alter table employees enable row level security;
alter table recibos enable row level security;
alter table admins enable row level security;
alter table notifications enable row level security;

-- Políticas: empleado solo ve sus propios datos
create policy "Empleado ve sus datos" on employees
  for select using (email = auth.jwt() ->> 'email');

create policy "Empleado ve sus recibos" on recibos
  for select using (
    employee_id in (
      select id from employees where email = auth.jwt() ->> 'email'
    )
  );

create policy "Empleado puede firmar su recibo" on recibos
  for update using (
    employee_id in (
      select id from employees where email = auth.jwt() ->> 'email'
    )
  );

create policy "Empleado ve sus notificaciones" on notifications
  for select using (
    employee_id in (
      select id from employees where email = auth.jwt() ->> 'email'
    )
  );

create policy "Empleado puede marcar notif leida" on notifications
  for update using (
    employee_id in (
      select id from employees where email = auth.jwt() ->> 'email'
    )
  );

-- Admin puede ver y modificar todo (usando service_role o función especial)
-- Por ahora, los admins se manejan desde el backend con anon key + validación en tabla admins

-- 6. ÍNDICES para performance con 1500 empleados
create index if not exists idx_recibos_employee on recibos(employee_id);
create index if not exists idx_recibos_periodo on recibos(periodo_anio, periodo_mes);
create index if not exists idx_recibos_estado on recibos(estado);
create index if not exists idx_notif_employee on notifications(employee_id);
create index if not exists idx_employees_email on employees(email);
create index if not exists idx_employees_dni on employees(dni);

-- ============================================================
-- STORAGE: hacerlo MANUALMENTE en Supabase
-- Storage → New Bucket → nombre: "recibos" → Public: OFF
-- ============================================================

-- ============================================================
-- DATOS DE PRUEBA (opcional, para testear)
-- ============================================================

-- Crear un empleado de prueba:
-- insert into employees (dni, legajo, nombre, apellido, email, sede, campana)
-- values ('12345678', 'OLV001', 'Juan', 'Pérez', 'juan.perez@mera.com.ar', 'Olivos', 'CSV');

-- Crear un admin de prueba:
-- insert into admins (email, nombre, rol)
-- values ('fserrao@mera.com.ar', 'Federico Serrao', 'superadmin');

-- IMPORTANTE: el usuario en Supabase Auth debe tener el mismo email que en employees o admins.
-- Crear usuarios en: Supabase → Authentication → Users → Invite user
