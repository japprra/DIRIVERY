<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Estilos y frameworks -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">

<!-- Librerías JavaScript -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://unpkg.com/babel-standalone@6.26.0/babel.min.js"></script>
<script src="https://unpkg.com/vue@3"></script>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<div class="container mt-4 text-center">
  <h2 class="text-success">Compra Realizada</h2>
  
  <div class="container mt-4">
  <div class="d-flex border" style="height:40px;">
    <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
   <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
    <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
    <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
  </div>
</div>
  
  <c:if test="${not empty mensaje}">
    <div class="alert alert-success">${mensaje}</div>
  </c:if>

  <a href="${pageContext.request.contextPath}/index.htm" class="btn btn-primary mt-3">
    Seguir comprando
  </a>
</div>

