<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear tu Menú</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="Styles15.css">
</head>
<body>
    <div class="container">
        <h1>Crear tu Menú</h1>
        <form action="CalculoComidas" method="post">
            <% 
                List<String> proteinas = (List<String>) request.getAttribute("proteinas");
                List<String> carbohidratos = (List<String>) request.getAttribute("carbohidratos");
                List<String> vitaminasMinerales = (List<String>) request.getAttribute("vitaminasMinerales");
                List<String> grasas = (List<String>) request.getAttribute("grasas");

                int numComidas = 5;
            %>

            <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
                <% for (int i = 1; i <= numComidas; i++) { %>
                    <div class="meal-section">
                        <h3>Comida <%= i %></h3>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="proteina<%= i %>">Proteína</label>
                                <select name="proteina<%= i %>" id="proteina<%= i %>">
                                    <option value="">Selecciona una proteína</option>
                                    <% for (String proteina : proteinas) { %>
                                        <option value="<%= proteina %>"><%= proteina %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="carbohidrato<%= i %>">Carbohidrato</label>
                                <select name="carbohidrato<%= i %>" id="carbohidrato<%= i %>">
                                    <option value="">Selecciona un carbohidrato</option>
                                    <% for (String carbohidrato : carbohidratos) { %>
                                        <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="vitaminasMinerales<%= i %>">Micronutrientes</label>
                                <select name="vitaminasMinerales<%= i %>" id="vitaminasMinerales<%= i %>">
                                    <option value="">Selecciona un micronutriente</option>
                                    <% for (String vitamina : vitaminasMinerales) { %>
                                        <option value="<%= vitamina %>"><%= vitamina %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="grasa<%= i %>">Grasa</label>
                                <select name="grasa<%= i %>" id="grasa<%= i %>">
                                    <option value="">Selecciona una grasa</option>
                                    <% for (String grasa : grasas) { %>
                                        <option value="<%= grasa %>"><%= grasa %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </div>
                <% } %>
                <div class="submit-container">
                    <input type="submit" value="Crear Menú">
                </div>
            <% } else { %>
                <div class="error-message">
                    <p>No se encontraron alimentos para este usuario.</p>
                </div>
            <% } %>
        </form>
    </div>
</body>
</html>