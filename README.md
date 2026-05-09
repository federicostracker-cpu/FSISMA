# FSISMA — Plataforma digital de recibos de sueldo
### MERA Solutions · Olivos & Parque Patricios

---

## 🚀 Cómo deployar en 6 pasos

### PASO 1 — Crear repositorio en GitHub
1. Entrá a github.com → **New repository**
2. Nombre: `FSISMA`
3. Público o privado (recomendado privado)
4. Subí todos estos archivos via drag & drop

---

### PASO 2 — Configurar Supabase
1. Entrá a supabase.com → **New project**
2. Nombre: `fsisma` · Elegí una contraseña segura
3. Una vez creado, andá a **SQL Editor** → **New query**
4. Copiá todo el contenido de `supabase-setup.sql` y ejecutalo
5. Andá a **Storage** → **New Bucket** → nombre: `recibos` → **Public: OFF**
6. Anotá tus keys en **Settings → API**:
   - `Project URL` → va en `NEXT_PUBLIC_SUPABASE_URL`
   - `anon public` → va en `NEXT_PUBLIC_SUPABASE_ANON_KEY`

---

### PASO 3 — Crear usuarios en Supabase Auth
1. Andá a **Authentication → Users → Invite user**
2. Creá un usuario con el mismo email que el empleado o admin
3. El usuario recibirá un email para setear contraseña

---

### PASO 4 — Insertar datos de prueba
En Supabase → **SQL Editor** → pegá y ejecutá:

```sql
-- Tu usuario admin
insert into admins (email, nombre, rol)
values ('tu-email@mera.com.ar', 'Tu Nombre', 'superadmin');

-- Un empleado de prueba
insert into employees (dni, legajo, nombre, apellido, email, sede, campana)
values ('12345678', 'OLV001', 'Juan', 'Pérez', 'juan.perez@mera.com.ar', 'Olivos', 'CSV');
```

---

### PASO 5 — Deployar en Vercel
1. Entrá a vercel.com → **New Project**
2. Importá el repo `FSISMA` de GitHub
3. En **Environment Variables** agregá:
   - `NEXT_PUBLIC_SUPABASE_URL` = tu URL de Supabase
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = tu anon key
4. Clic en **Deploy**

---

### PASO 6 — ¡Listo!
- La app va a estar en `https://fsisma.vercel.app` (o similar)
- Entrá con tu email de admin → te lleva a `/admin`
- Entrá con un email de empleado → te lleva a `/dashboard`

---

## 📁 Estructura de carpetas

```
FSISMA/
├── app/
│   ├── layout.js               ← configuración global
│   ├── page.js                 ← redirige según rol
│   ├── login/page.js           ← login empleado y admin
│   ├── dashboard/page.js       ← vista de recibos del empleado
│   ├── recibos/[id]/page.js    ← recibo individual + firma
│   └── admin/
│       ├── page.js             ← dashboard con métricas
│       └── upload/page.js      ← carga masiva de PDFs
├── components/
│   ├── Header.js               ← navbar
│   ├── ReciboCard.js           ← tarjeta de recibo
│   └── FirmaModal.js           ← modal de firma/disconformidad
├── lib/
│   ├── supabaseClient.js       ← conexión a Supabase
│   └── helpers.js              ← todas las funciones de datos
└── supabase-setup.sql          ← script SQL completo
```

---

## 💡 Cómo subir recibos (admin)

1. Nombrá los PDFs con el DNI del empleado: `12345678.pdf`
2. Andá a **Admin → Cargar recibos**
3. Arrastrá todos los PDFs a la zona de drop
4. El sistema detecta automáticamente el empleado por DNI
5. Revisá las asignaciones y hacé clic en **Publicar**

---

## ⚖️ Marco legal

Cumple con:
- Resolución MTEySS N° 1455/11 (habilitación de recibos digitales)
- Resolución 346/2019 (recibos electrónicos obligatorios)

Los empleados pueden firmar en **conformidad** o **disconformidad** con observación de texto libre. Todas las firmas quedan registradas con fecha y hora.

---

## 🛠️ Stack
- **Next.js 14** (App Router)
- **Supabase** (auth + base de datos + storage)
- **Vercel** (hosting)
- **Tailwind CSS** (estilos)
