<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Blog - DIRI VERY</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .blog-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        .blog-img {
            height: 250px;
            object-fit: cover;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">Noticias & Novedades de DIRI VERY</h2>

    <div class="blog-card">
        <img src="https://img.freepik.com/foto-gratis/concepto-almacen-entrega-cajas-paquetes-almacenamiento_342744-1426.jpg" class="blog-img" alt="Delivery a tiendas">
        <div class="p-4">
            <h4>🚚 Conectando fábricas con tiendas minoristas</h4>
            <p>En DIRI VERY trabajamos directamente con productores y fábricas para llevar los mejores productos hasta tu tienda. Eliminamos intermediarios para ofrecer precios justos y rapidez en la entrega.</p>
            <p class="text-muted">Publicado el 25 de septiembre, 2025</p>
        </div>
    </div>

    <div class="blog-card">
        <img src="https://img.freepik.com/foto-gratis/concepto-almacen-entrega-cajas-paquetes-almacenamiento_342744-1426.jpg" class="blog-img" alt="Consejos delivery">
        <div class="p-4">
            <h4>📦 5 consejos para mejorar tu experiencia de compra al por mayor</h4>
            <p>Desde verificar la trazabilidad de los productos hasta coordinar tus pedidos con anticipación. Te compartimos recomendaciones para que tu negocio siempre esté abastecido a tiempo.</p>
            <p class="text-muted">Publicado el 18 de septiembre, 2025</p>
        </div>
    </div>

    <div class="blog-card">
        <img src="https://img.freepik.com/foto-gratis/cajas-carton-palets-mercancia-almacen-logistica_342744-1339.jpg" class="blog-img" alt="Novedades DIRI VERY">
        <div class="p-4">
            <h4>🆕 Nuevos productos directos de fábrica disponibles</h4>
            <p>Ampliamos nuestro catálogo con nuevas líneas de productos frescos y manufacturados, listos para ser entregados a tu negocio en tiempo récord. ¡Haz tu pedido hoy mismo!</p>
            <p class="text-muted">Publicado el 12 de septiembre, 2025</p>
        </div>
    </div>

</div>
    
    <!-- Footer -->
  <footer class="footer bg-light py-3 mt-5">
    <div class="container text-center">
      © 2025 DIRI VERY. Todos los derechos reservados.
    </div>
  </footer>
    <!-- Bootstrap 5 JS Bundle -->

</html>
