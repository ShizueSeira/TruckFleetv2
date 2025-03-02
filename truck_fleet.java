package Models;

public class truck_fleet {
    private String truckModel;
    
    private String truckManufacturer;
    private int truckManufacturerYear;
    private String truckLicensePlate;
    private String truckLastMaintenance;
    private String truckNextMaintenance;
    private String truckEngine;
    private int truckId;

    
    public truck_fleet() {}
    
    //parameterized constructor
    public truck_fleet(int truckId,String truckModel, String truckManufacturer, int truckManufacturerYear, String truckLicensePlate, String truckLastMaintenance, String truckNextMaintenance, String truckEngine) {
        this.truckId=truckId;
        this.truckModel = truckModel;
        this.truckManufacturer = truckManufacturer;
        this.truckManufacturerYear = truckManufacturerYear;
        this.truckLicensePlate = truckLicensePlate;
        this.truckLastMaintenance = truckLastMaintenance;
        this.truckNextMaintenance = truckNextMaintenance;
        this.truckEngine = truckEngine;
    }
    
        // Getters and Setters
    public int getTruckId() {
        return truckId;
    }
    
    //getter
    public String getTruckModel() { 
        return truckModel; 
    }
    
    public String getTruckManufacturer() { 
        return truckManufacturer; 
    }
    
    public int getTruckManufacturerYear() { 
        return truckManufacturerYear; 
    }
    
    public String getTruckLicensePlate() { 
        return truckLicensePlate; 
    }
    
    public String getTruckLastMaintenance() { 
        return truckLastMaintenance; 
    }
    
    public String getTruckNextMaintenance() { 
        return truckNextMaintenance; 
    }
    
     public String getTruckEngine() { 
        return truckEngine; 
    }   
    
    //setter
    public void setTruckId(int truckId) {
        this.truckId = truckId;
    }     
     
    public void setTruckModel(String truckModel) { 
        this.truckModel = truckModel; 
    }
    
    public void setTruckManufacturer(String truckManufacturer) { 
        this.truckManufacturer = truckManufacturer; 
    }
    
    public void setTruckManufacturerYear(int truckManufacturerYear) { 
        this.truckManufacturerYear = truckManufacturerYear; 
    }
    
    public void setTruckLicensePlate(String truckLicensePlate) { 
        this.truckLicensePlate = truckLicensePlate; 
    }
    
    public void setTruckLastMaintenance(String truckLastMaintenance) { 
        this.truckLastMaintenance = truckLastMaintenance; 
    }
    
    public void setTruckNextMaintenance(String truckNextMaintenance) { 
        this.truckNextMaintenance = truckNextMaintenance; 
    }
    
    public void setTruckEngine(String truckEngine) { 
        this.truckEngine = truckEngine; 
    }    
    public void removeTruck() {}
}
