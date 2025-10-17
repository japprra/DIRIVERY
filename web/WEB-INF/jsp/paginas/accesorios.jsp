<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agroindustria</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Iconos de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap 5 CSS -->
    <link 
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
      rel="stylesheet"
      crossorigin="anonymous"
    >
    <!-- Estilos propios -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/paginas.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">

    
       <style>
        .producto-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }
        .producto-card:hover {
            transform: scale(1.03);
        }
        .producto-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .proveedor {
            font-size: 0.9rem;
            color: #555;
            background-color: #f8f9fa;
            padding: 4px 8px;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 6px;
        }
    </style>
</head>
<body class="bg-light">

    <%@ include file="/WEB-INF/jsp/menu.jsp" %>

    <div class="container mt-4">
        <h2 class="mb-4 text-center">Agroindustria</h2>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty productos}">
                    <c:forEach var="producto" items="${productos}">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="card producto-card h-100">
                                <img 
                                  src="${empty producto.imagen ? pageContext.request.contextPath+'/img/default.png' : producto.imagen}" 
                                  alt="${producto.nombre}" 
                                  class="card-img-top producto-img">
                                <div class="card-body d-flex flex-column">
                                    
                                    <!-- Nombre del producto -->
                                    <h5 class="card-title text-center">${producto.nombre}</h5>

                                    <!-- 🔹 Proveedor -->
                                    <c:choose>
                                        <c:when test="${not empty producto.proveedorNombre}">
                                            <p class="text-muted text-center mb-2">
                                                <i class="bi bi-truck"></i> Proveedor: 
                                                <strong>${producto.proveedorNombre}</strong>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted text-center mb-2">
                                                <i class="bi bi-truck"></i> Sin proveedor
                                            </p>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Precio -->
                                    <p class="text-center mb-2">Precio: $<strong>${producto.precio}</strong></p>
                                    
                                    <!-- Cantidad disponible -->
                                    <c:choose>
                                        <c:when test="${producto.cantidad > 0}">
                                            <p class="card-text mb-2 text-success text-center">
                                                Disponible: <strong>${producto.cantidad}</strong> unidades
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="card-text mb-2 text-danger text-center">Agotado</p>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- ❌ Se quitó la descripción (no mostrar) -->

                                    <!-- Botón agregar -->
                                    <c:choose>
                                        <c:when test="${producto.cantidad > 0}">
                                            <a href="${pageContext.request.contextPath}/carrito/agregar.htm?id=${producto.idprod}&redirect=accesorios"
                                               class="mt-auto btn btn-success btn-sm">Agregar al carrito</a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="mt-auto btn btn-secondary btn-sm" disabled>Agotado</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center">
                        <div class="alert alert-info">No hay accesorios disponibles en este momento.</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-light py-3 mt-5">
        <div class="container text-center">
            © 2025 Mi Perú. Todos los derechos reservados.
        </div>
    </footer>

</body>
</html>
