<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registro de Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {
      background-color: #f8f9fa;
      padding-top: 80px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-md-6 col-lg-5 bg-white p-5 shadow rounded">

        <h3 class="mb-4 text-center">Registro de Usuario</h3>

        <form method="post" action="${pageContext.request.contextPath}/registro.htm">
          <div class="mb-3">
            <label for="cuenta" class="form-label">Cuenta</label>
            <input type="text" class="form-control" id="cuenta" name="cuenta" required>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>

          <div class="mb-3">
            <label for="nombre" class="form-label">RUC</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>

          <div class="d-grid">
            <button type="submit" class="btn btn-primary">Registrar</button>
          </div>
        </form>

        <c:if test="${not empty error}">
          <div class="alert alert-danger mt-3">${error}</div>
        </c:if>

        <c:if test="${not empty mensaje}">
          <div class="alert alert-info mt-3">${mensaje}</div>
        </c:if>

      </div>
    </div>
  </div>
       <!-- Footer -->
  <footer class="footer py-3 mt-5">
    <div class="container text-center">
      © 2025 Mi Perú. Todos los derechos reservados.
    </div>
  </footer>    
</body>

</html>