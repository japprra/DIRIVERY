<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>DIRI VERY – Inicio</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Iconos -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Estilos personalizados -->
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>

<body>

  <!-- ✅ Menú superior -->
  <%@ include file="/WEB-INF/jsp/menu.jsp" %>



  <!-- ✅ Sección Hero -->
  <section class="hero text-center py-5">
    <div class="container">
      <h1 class="fw-bold mb-3">Bienvenido a DIRI VERY</h1>
      <p class="lead mb-4">De la fábrica a tu tienda en horas – Delivery rápido en Lima</p>
    </div>
  </section>

  <!-- ✅ Categorías destacadas -->
  <div class="container mb-5">
    <h2 class="text-center mb-4 text-primary">
      <i class="bi bi-grid-3x3-gap-fill"></i> Categorías Destacadas
    </h2>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">

      <div class="col">
        <a href="${pageContext.request.contextPath}/polo.htm?categoria=polos"
           class="card categoria-card text-decoration-none h-100">
          <img src="${pageContext.request.contextPath}/img/anillo.jpg" class="card-img-top" alt="Artesanía y cultura">
          <div class="card-body text-center">
            <h5 class="card-title">Artesanía y cultura</h5>
          </div>
        </a>
      </div>

      <div class="col">
        <a href="${pageContext.request.contextPath}/cuadros.htm?categoria=cuadros"
           class="card categoria-card text-decoration-none h-100">
          <img src="${pageContext.request.contextPath}/img/zapato.webp" class="card-img-top" alt="Industria y manufactura">
          <div class="card-body text-center">
            <h5 class="card-title">Industria y manufactura</h5>
          </div>
        </a>
      </div>

      <div class="col">
        <a href="${pageContext.request.contextPath}/accesorios.htm?categoria=accesorios"
           class="card categoria-card text-decoration-none h-100">
          <img src="${pageContext.request.contextPath}/img/cacao.png" class="card-img-top" alt="Agroindustria">
          <div class="card-body text-center">
            <h5 class="card-title">Agroindustria</h5>
          </div>
        </a>
      </div>

      <div class="col">
        <a href="#" class="card categoria-card text-decoration-none h-100">
          <img src="${pageContext.request.contextPath}/img/ACCESORIO1.png" class="card-img-top" alt="Bebidas y abarrotes">
          <div class="card-body text-center">
            <h5 class="card-title">Bebidas y abarrotes</h5>
          </div>
        </a>
      </div>

      <div class="col">
        <a href="#" class="card categoria-card text-decoration-none h-100">
          <img src="${pageContext.request.contextPath}/img/PENDIENTE1.webp" class="card-img-top" alt="Textiles y consumo">
          <div class="card-body text-center">
            <h5 class="card-title">Textiles y consumo</h5>
          </div>
        </a>
      </div>

    </div>
  </div>

  <!-- ✅ Catálogo de productos -->
  <%@ include file="/WEB-INF/jsp/paginas/catalogoProductos.jsp" %>

  <!-- ✅ Footer -->
  <footer class="footer py-3 mt-5 bg-light">
    <div class="container text-center">
      © 2025 DIRI VERY. Delivery rápido en Lima - Perú. Todos los derechos reservados.
    </div>
  </footer>

  <!-- Bootstrap Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/catalogo.js"></script>

</body>
</html>
