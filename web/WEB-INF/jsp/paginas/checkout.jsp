    <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Estilos y frameworks -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">

<!-- Librerías JavaScript -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://unpkg.com/babel-standalone@6.26.0/babel.min.js"></script>
<script src="https://unpkg.com/vue@3"></script>

<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<div class="container mt-4">
  <h2 class="text-center">Confirmación de Compra</h2>
  
  <div class="container mt-4">
  <div class="d-flex border" style="height:40px;">
    <!-- Primer bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
    <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
   <!-- Segundo bloque amarillo -->
    <div class="flex-fill bg-warning border-end"></div>
   <!-- Tercer bloque blanco -->
    <div class="flex-fill bg-light border-end"></div>
  </div>
</div>

  <c:if test="${not empty mensajeError}">
    <div class="alert alert-danger text-center">${mensajeError}</div>
  </c:if>

  <c:if test="${not empty carrito}">
    <table class="table table-bordered">
      <thead>
        <tr>
          <th>Producto</th>
          <th>Precio</th>
          <th>Cantidad</th>
          <th>Subtotal</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="p" items="${carrito}">
          <tr>
            <td>${p.nombre}</td>
            <td>$ ${p.precio}</td>
            <td>${p.cantidad}</td>
            <td>$ ${p.precio * p.cantidad}</td>
          </tr>
        </c:forEach>
      </tbody>
      <tfoot>
        <tr>
          <th colspan="3" class="text-end">Total:</th>
          <th>$ ${total}</th>
        </tr>
      </tfoot>
    </table>

    <!-- Formulario para contacto y destino -->
    <form action="${pageContext.request.contextPath}/procesarPedido.htm" method="post">
        


      <!-- Contacto del comprador -->
      <div class="mb-3">
        <label for="contacto" class="form-label fw-bold">Contacto del comprador:</label>
        <input type="text" class="form-control" id="contacto" name="contacto"
               placeholder="Ejemplo: 987654321 o correo@ejemplo.com" required>
      </div>

     <!-- Selección de destino -->
<div class="mb-3">
  <label for="destino" class="form-label fw-bold">Selecciona el distrito de entrega en Lima:</label>
  <select class="form-select" id="destino" name="destino" required>
    <option value="" selected disabled>-- Seleccionar distrito --</option>
    
    <option value="Ancón">Ancón</option>
    <option value="Ate">Ate</option>
    <option value="Barranco">Barranco</option>
    <option value="Breña">Breña</option>
    <option value="Carabayllo">Carabayllo</option>
    <option value="Chaclacayo">Chaclacayo</option>
    <option value="Chorrillos">Chorrillos</option>
    <option value="Cieneguilla">Cieneguilla</option>
    <option value="Comas">Comas</option>
    <option value="El Agustino">El Agustino</option>
    <option value="Independencia">Independencia</option>
    <option value="Jesús María">Jesús María</option>
    <option value="La Molina">La Molina</option>
    <option value="La Victoria">La Victoria</option>
    <option value="Lima">Lima (Centro Histórico)</option>
    <option value="Lince">Lince</option>
    <option value="Los Olivos">Los Olivos</option>
    <option value="Lurigancho-Chosica">Lurigancho-Chosica</option>
    <option value="Lurín">Lurín</option>
    <option value="Magdalena del Mar">Magdalena del Mar</option>
    <option value="Miraflores">Miraflores</option>
    <option value="Pachacámac">Pachacámac</option>
    <option value="Pucusana">Pucusana</option>
    <option value="Pueblo Libre">Pueblo Libre</option>
    <option value="Puente Piedra">Puente Piedra</option>
    <option value="Punta Hermosa">Punta Hermosa</option>
    <option value="Punta Negra">Punta Negra</option>
    <option value="Rímac">Rímac</option>
    <option value="San Bartolo">San Bartolo</option>
    <option value="San Borja">San Borja</option>
    <option value="San Isidro">San Isidro</option>
    <option value="San Juan de Lurigancho">San Juan de Lurigancho</option>
    <option value="San Juan de Miraflores">San Juan de Miraflores</option>
    <option value="San Luis">San Luis</option>
    <option value="San Martín de Porres">San Martín de Porres</option>
    <option value="San Miguel">San Miguel</option>
    <option value="Santa Anita">Santa Anita</option>
    <option value="Santa María del Mar">Santa María del Mar</option>
    <option value="Santa Rosa">Santa Rosa</option>
    <option value="Santiago de Surco">Santiago de Surco</option>
    <option value="Surquillo">Surquillo</option>
    <option value="Villa El Salvador">Villa El Salvador</option>
    <option value="Villa María del Triunfo">Villa María del Triunfo</option>
  </select>
</div>

      <!-- Ubicación detallada -->
<div class="mb-3">
  <label for="ubicacion" class="form-label fw-bold">Ubicación detallada (dirección exacta):</label>
  <input type="text" class="form-control" id="ubicacion" name="ubicacion"
         placeholder="Ejemplo: Av. Los Álamos 123, Urb. Centro, Cusco" required>
</div>


      <!-- Botón de confirmación -->
      <div class="text-center mt-4">
        <button type="submit" class="btn btn-primary">Confirmar y Pagar</button>

      </div>
    </form>
  </c:if>
</div>
