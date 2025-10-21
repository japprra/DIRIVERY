<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Diri Very - Navbar</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Tus estilos -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css" />
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">DIRI VERY</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                aria-controls="navbarContent" aria-expanded="false" aria-label="Mostrar/Ocultar menú">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <!-- Menú principal -->
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Inicio</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="productosDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Productos
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="productosDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/polo.htm">Artesanía y cultura</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cuadros.htm">Industria y manufactura</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accesorios.htm">Agroindustria</a></li>
                    </ul>
                </li>

                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contacto.htm">Contacto</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/blog.htm">Blog</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/servicioCliente.htm">Servicio al Cliente</a></li>
            </ul>

            <!-- Buscador -->
            <form class="d-flex me-3" role="search" method="get" action="${pageContext.request.contextPath}/busqueda.htm">
                <input class="form-control me-2" type="search" name="query" placeholder="Buscar productos..." aria-label="Buscar">
                <button class="btn btn-outline-light" type="submit">Buscar</button>
            </form>

            <!-- Carrito -->
            <ul class="navbar-nav mb-2 mb-lg-0">
                <c:set var="cantCarrito" value="${sessionScope.carrito != null ? fn:length(sessionScope.carrito) : 0}" />

                <a class="nav-link" href="${pageContext.request.contextPath}/carrito/ver.htm">
                    🛒 Carrito
                    <span id="contadorCarrito" class="badge bg-warning text-dark">
                        <c:out value="${cantCarrito}" />
                    </span>
                </a>

                <!-- Usuario / Cuenta -->
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${sessionScope.usuario.nombre}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout.htm">Cerrar sesión</a></li>
                            </ul>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="authDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Cuenta
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="authDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login.htm">Iniciar Sesión</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/registro.htm">Registrarse</a></li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Separación del contenido y navbar -->
<div class="pt-5"></div>

<!-- Bootstrap 5 Bundle JS (incluye Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
