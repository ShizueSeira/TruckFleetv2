<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Models.truck_fleet, java.util.List, Models.users, java.util.HashSet, java.util.Set" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Fleet</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <!-- Include Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
        <!-- Add JavaScript to handle modal functionality -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Add Truck Modal
                const addModal = document.getElementById("addModal");
                const addBtn = document.querySelector(".add-button");
                const addClose = document.querySelector(".add-close");

                addBtn.addEventListener("click", function () {
                    addModal.style.display = "block";
                });

                addClose.addEventListener("click", function () {
                    addModal.style.display = "none";
                });

                window.addEventListener("click", function (event) {
                    if (event.target === addModal) {
                        addModal.style.display = "none";
                    }
                });

                // Edit Truck Modal
                const editModal = document.getElementById("editModal");
                const editClose = document.querySelector(".edit-close");

                // Open Edit Modal when clicking the pencil icon
                document.querySelectorAll(".edit-truck").forEach(button => {
                    button.addEventListener("click", function () {
                        const truckId = this.getAttribute("data-truck-id");
                        const truckModel = this.getAttribute("data-truck-model");
                        const truckEngine = this.getAttribute("data-truck-engine");
                        const truckLicensePlate = this.getAttribute("data-truck-licenseplate");
                        const truckManufacturer = this.getAttribute("data-truck-manufacturer");
                        const truckManufacturerYear = this.getAttribute("data-truck-manufactureryear");
                        const truckLastMaintenance = this.getAttribute("data-truck-lastmaintenance");
                        const truckNextMaintenance = this.getAttribute("data-truck-nextmaintenance");

                        // Pre-fill the edit form with the truck's data
                        document.getElementById("editTruckId").value = truckId;
                        document.getElementById("editTruckModel").value = truckModel;
                        document.getElementById("editTruckEngine").value = truckEngine;
                        document.getElementById("editTruckLicensePlate").value = truckLicensePlate;
                        document.getElementById("editTruckManufacturer").value = truckManufacturer;
                        document.getElementById("editTruckManufacturerYear").value = truckManufacturerYear;
                        document.getElementById("editTruckLastMaintenance").value = truckLastMaintenance;
                        document.getElementById("editTruckNextMaintenance").value = truckNextMaintenance;

                        // Show the edit modal
                        editModal.style.display = "block";
                    });
                });

                editClose.addEventListener("click", function () {
                    editModal.style.display = "none";
                });

                window.addEventListener("click", function (event) {
                    if (event.target === editModal) {
                        editModal.style.display = "none";
                    }
                });

                // Plate Number Filter
                const plateNumberSearch = document.getElementById("plateNumberSearch");
                const engineModelSearch = document.getElementById("engineModelSearch");
                const makeFilter = document.getElementById("makeFilter"); // Third filter for Make
                const modelFilter = document.getElementById("modelFilter"); // Fourth filter for Model
                const truckRows = document.querySelectorAll(".itemlist tr");

                plateNumberSearch.addEventListener("input", function () {
                    const searchTerm = plateNumberSearch.value.trim().toLowerCase();

                    truckRows.forEach(row => {
                        const plateNumber = row.querySelector("td:nth-child(1)").textContent.toLowerCase();

                        if (plateNumber.includes(searchTerm)) {
                            row.style.display = ""; // Show the row
                        } else {
                            row.style.display = "none"; // Hide the row
                        }
                    });
                });

                // Engine Model Filter
                engineModelSearch.addEventListener("input", function () {
                    const searchTerm = engineModelSearch.value.trim().toLowerCase();

                    truckRows.forEach(row => {
                        const engineModel = row.querySelector("td:nth-child(4)").textContent.toLowerCase();

                        if (engineModel.includes(searchTerm)) {
                            row.style.display = ""; // Show the row
                        } else {
                            row.style.display = "none"; // Hide the row
                        }
                    });
                });

                // Make Filter (Third Filter)
                makeFilter.addEventListener("change", function () {
                    const selectedMake = makeFilter.value.toLowerCase();

                    truckRows.forEach(row => {
                        const make = row.querySelector("td:nth-child(2)").textContent.toLowerCase();

                        if (selectedMake === "" || make === selectedMake) {
                            row.style.display = ""; // Show the row
                        } else {
                            row.style.display = "none"; // Hide the row
                        }
                    });
                });

                // Model Filter (Fourth Filter)
                modelFilter.addEventListener("change", function () {
                    const selectedModel = modelFilter.value.toLowerCase();

                    truckRows.forEach(row => {
                        const model = row.querySelector("td:nth-child(3)").textContent.toLowerCase();

                        if (selectedModel === "" || model === selectedModel) {
                            row.style.display = ""; // Show the row
                        } else {
                            row.style.display = "none"; // Hide the row
                        }
                    });
                });
            });
        </script>
    </head>

    <body>
        <%
            // Prevent caching of this page
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            // Check session for user status
            String sessionId = session.getId();
            users current = (users) session.getAttribute(sessionId);

            if (current == null || !current.getStatus()) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Retrieve the truck data from the session
            List<truck_fleet> trucks = (List<truck_fleet>) session.getAttribute("trucks");

            // Check for errors
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
                out.println("<p style='color: red;'>" + errorMessage + "</p>");
                session.removeAttribute("errorMessage"); // Clear the error message after displaying it
            }

            // Get unique values for Make and Model
            Set<String> uniqueMakes = new HashSet<String>(); // Explicit generic type
            Set<String> uniqueModels = new HashSet<String>(); // Explicit generic type
            if (trucks != null && !trucks.isEmpty()) {
                for (truck_fleet truck : trucks) {
                    uniqueMakes.add(truck.getTruckManufacturer());
                    uniqueModels.add(truck.getTruckModel());
                }
            }
        %>

        <header>
            <div class="new-path">
                <a href="dashboard.jsp" class="newpathformat">Dashboard</a>
                <p class="new-patharrow">&gt;</p>
                <a href="#" class="newpathformat">Manage Fleet</a>
            </div>
        </header>

        <div class="parts-content">
            <div class="header-container">
                <a href="dashboard.jsp" class="parts-back">&lt; Back</a>
                <h1 class="h1-parts">Manage Fleet</h1>
            </div>

            <div class="parts-container">
                <div class="filtering">
                    <div class="filter-option">
                        <h3 class="filtering-desc">Search Plate Number:</h3>
                        <input type="text" id="plateNumberSearch" class="filter-search" placeholder="Enter Plate Number">
                    </div>
                    <div class="filter-option">
                        <h3 class="filtering-desc">Search Engine Model:</h3>
                        <input type="text" id="engineModelSearch" class="filter-search" placeholder="Enter Engine Model">
                    </div>
                    <div class="filter-option">
                        <h3 class="filtering-desc">Filter by Make:</h3>
                        <select id="makeFilter" class="filter-select">
                            <option value="">All Makes</option>
                            <%
                                for (String make : uniqueMakes) {
                            %>
                            <option value="<%= make %>"><%= make %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="filter-option">
                        <h3 class="filtering-desc">Filter by Model:</h3>
                        <select id="modelFilter" class="filter-select">
                            <option value="">All Models</option>
                            <%
                                for (String model : uniqueModels) {
                            %>
                            <option value="<%= model %>"><%= model %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Display the truck list -->
                <div class="parts-list">
                    <table class="gen-table">
                        <thead>
                            <tr>
                                <th class="gen-columnname">Plate Number</th> <!-- Index 1 -->
                                <th class="gen-columnname">Make</th> <!-- Index 2 -->
                                <th class="gen-columnname">Model</th> <!-- Index 3 -->
                                <th class="gen-columnname">Engine</th> <!-- Index 4 -->
                                <th class="gen-columnname">Manufacturer Year</th> <!-- Index 5 -->
                                <th class="gen-columnname">Last Maintenance</th> <!-- Index 6 -->
                                <th class="gen-columnname">Next Maintenance</th> <!-- Index 7 -->
                                <th class="gen-columnname">Actions</th> <!-- Not filtered -->
                            </tr>
                        </thead>
                        <tbody class="itemlist">
                            <%
                                if (trucks != null && !trucks.isEmpty()) {
                                    for (truck_fleet truck : trucks) {
                            %>
                            <tr>
                                <td><%= truck.getTruckLicensePlate() %></td> <!-- Index 1 -->
                                <td><%= truck.getTruckManufacturer() %></td> <!-- Index 2 -->
                                <td><%= truck.getTruckModel() %></td> <!-- Index 3 -->
                                <td><%= truck.getTruckEngine() %></td> <!-- Index 4 -->
                                <td><%= truck.getTruckManufacturerYear() %></td> <!-- Index 5 -->
                                <td><%= truck.getTruckLastMaintenance() %></td> <!-- Index 6 -->
                                <td><%= truck.getTruckNextMaintenance() %></td> <!-- Index 7 -->
                                <td>
                                    <!-- Actions column (not filtered) -->
                                    <a href="#" class="edit-truck" data-truck-id="<%= truck.getTruckId() %>">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                    <a href="DeleteTruckServlet?licensePlate=<%= truck.getTruckLicensePlate() %>" 
                                       onclick="return confirm('Are you sure you want to delete this truck?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7">No trucks available</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Action buttons -->
            <div class="button-container">
                <div class="left-buttons">
                    <button class="export-button">Export as Excel</button>
                    <button class="export-button">Export as PDF</button>
                </div>
                <div class="right-buttons">
                    <button class="add-button">Add Truck</button>
                </div>
            </div>
        </div>

        <!-- Add Truck Modal -->
        <div id="addModal" class="add-modal">
            <div class="addmodal-box">
                <div class="addmodal-content">
                    <span class="close add-close">&times;</span>
                    <h1 style="color: #5271ff;">Add Truck</h1>
                    
                    <!-- Form to submit truck details -->
                    <form id="addTruckForm" action="AddTruckServlet" method="POST">
                        <div class="add-details-textbox">
                            <label class="option-label">Truck Model</label>
                            <input type="text" name="truckModel" class="item-options" placeholder="Enter Truck Model" required>

                            <label class="option-label">Truck Engine</label>
                            <input type="text" name="truckEngine" class="item-options" placeholder="Enter Truck Engine" required>

                            <label class="option-label">License Plate</label>
                            <input type="text" name="truckLicensePlate" class="item-options" placeholder="Enter License Plate" required>

                            <label class="option-label">Truck Manufacturer</label>
                            <input type="text" name="truckManufacturer" class="item-options" placeholder="Enter Truck Manufacturer" required>

                            <label class="option-label">Manufacturer Year</label>
                            <input type="number" name="truckManufacturerYear" class="item-options" placeholder="Enter Manufacturer Year" required>

                            <label class="option-label">Last Maintenance Date</label>
                            <input type="date" name="truckLastMaintenance" class="item-options" required>

                            <label class="option-label">Next Maintenance Date</label>
                            <input type="date" name="truckNextMaintenance" class="item-options" required>
                        </div>

                        <button type="submit" id="addButton" class="addbutton">Add Truck</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Truck Modal -->
        <div id="editModal" class="add-modal">
            <div class="addmodal-box">
                <div class="addmodal-content">
                    <span class="close edit-close">&times;</span>
                    <h1 style="color: #5271ff;">Edit Truck</h1>
                    
                    <!-- Form to submit updated truck details -->
                    <form id="editTruckForm" action="EditTruckServlet" method="POST">
                        <input type="hidden" id="editTruckId" name="truckId">
                        
                        <div class="add-details-textbox">
                            <label class="option-label">Truck Model</label>
                            <input type="text" id="editTruckModel" name="truckModel" class="item-options" placeholder="Enter Truck Model" required>

                            <label class="option-label">Truck Engine</label>
                            <input type="text" id="editTruckEngine" name="truckEngine" class="item-options" placeholder="Enter Truck Engine" required>

                            <label class="option-label">License Plate</label>
                            <input type="text" id="editTruckLicensePlate" name="truckLicensePlate" class="item-options" placeholder="Enter License Plate" required>

                            <label class="option-label">Truck Manufacturer</label>
                            <input type="text" id="editTruckManufacturer" name="truckManufacturer" class="item-options" placeholder="Enter Truck Manufacturer" required>

                            <label class="option-label">Manufacturer Year</label>
                            <input type="number" id="editTruckManufacturerYear" name="truckManufacturerYear" class="item-options" placeholder="Enter Manufacturer Year" required>

                            <label class="option-label">Last Maintenance Date</label>
                            <input type="date" id="editTruckLastMaintenance" name="truckLastMaintenance" class="item-options" required>

                            <label class="option-label">Next Maintenance Date</label>
                            <input type="date" id="editTruckNextMaintenance" name="truckNextMaintenance" class="item-options" required>
                        </div>

                        <button type="submit" id="editButton" class="addbutton">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
