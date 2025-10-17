<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel Admin – Mi Perú</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body {
      height: 100%;
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding: 0;
    }

    /* Fijar espacio bajo navbar fijo */
    .admin-content {
      margin-top: 70px; /* Ajustar al alto real del navbar */
      padding-bottom: 80px;
    }

    .navbar-tech {
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
      border-bottom: 2px solid #00fff7;
      box-shadow: 0 0 10px #00fff7;
    }

    .navbar-tech .navbar-brand {
      color: #00fff7;
      font-weight: bold;
    }

    .navbar-tech .nav-link {
      color: #c0f0ff;
      transition: .3s;
    }

    .navbar-tech .nav-link:hover {
      color: #00fff7;
      background-color: rgba(0,255,247,.1);
      border-radius: 5px;
    }

    .navbar-tech .nav-link.text-danger:hover {
      background-color: rgba(255,0,0,.1);
      color: #ff4c4c;
    }

    .footer-tech {
      position: fixed;
      bottom: 0;
      width: 100%;
      height: 60px;
      line-height: 60px;
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
      color: #c0f0ff;
      text-align: center;
      box-shadow: 0 -1px 10px rgba(0,255,247,.3);
      font-size: .9rem;
    }
  </style>
</head>
<body>

<!-- Navbar Fijo -->
<nav class="navbar navbar-expand-lg navbar-tech fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/panelProductos.htm">
      PANEL ADMINISTRATIVO
    </a>
    <button class="navbar-toggler text-light" type="button"
            data-bs-toggle="collapse" data-bs-target="#menuNavAdmin"
            aria-controls="menuNavAdmin" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="menuNavAdmin">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
<a class="nav-link" href="${pageContext.request.contextPath}/agregarProducto.htm">
    Ingresar Producto
</a>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/panelUsuario.htm">Gestión Usuarios</a>
        </li>
          <!-- 🔹 NUEVO: Enlace para gestionar proveedores -->
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proveedores/listar">
            Gestionar Proveedores
          </a>
        </li>
<a class="nav-link" href="${pageContext.request.contextPath}/panelProductos.htm">
    Lista de Productos
</a>
<a class="nav-link" href="${pageContext.request.contextPath}/pedidos.htm">
    Ver Pedidos
</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/verContactos.htm">
    Ver Mensajes
      </ul>
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout.htm">Cerrar sesión</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Contenido -->
<div class="admin-content">
  <!-- Aquí va el contenido de la página -->
  <!-- Ejemplo: <div class="container mt-4">Contenido aquí</div> -->
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
</body>
</html>