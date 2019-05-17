package de.rwth.idsg.steve.web.dto.rest;

import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;


@Data
public class CreateTaskRequest {
    @NotNull
    private String chargeBoxId;

    @Min(value = 0, message = "Connector ID must be at least {value}")
    private int connectorId;

    @NotNull
    private TaskType type;

    private ChangeAvailabilityRequest changeAvailability;

    public enum TaskType {
        CHANGE_AVAILABILITY
    }
}
