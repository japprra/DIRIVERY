<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ingreso al Sistema</title>
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" 
        crossorigin="anonymous">

  <!-- CSS personalizado -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos.css">

  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body class="d-flex justify-content-center align-items-center min-vh-100 bg-light">

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-md-6 col-lg-4 bg-white p-4 shadow rounded">
        
        <!-- Título -->
        <h3 class="mb-4 text-center">Ingreso al Sistema</h3>
        
        <!-- Formulario de login -->
        <form action="${pageContext.request.contextPath}/login.htm" method="post">
          <div class="mb-3">
            <label for="cuenta" class="form-label">Ingrese tu cuenta</label>
            <input type="text" name="cuenta" id="cuenta" class="form-control" required>
          </div>

          <div class="mb-3">
            <label for="clave" class="form-label">Ingrese tu contraseña</label>
            <input type="password" name="clave" id="clave" class="form-control" required>
          </div>

          <input type="submit" value="Ingresar" class="btn btn-primary w-100">
        </form>

        <!-- Mensajes dinámicos -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger mt-3" role="alert">
            ${error}
          </div>
        </c:if>

        <c:if test="${not empty mensaje}">
          <div class="alert alert-info mt-3" role="alert">
            ${mensaje}
          </div>
        </c:if>

      </div>
    </div>
  </div>



</body>
</html>
