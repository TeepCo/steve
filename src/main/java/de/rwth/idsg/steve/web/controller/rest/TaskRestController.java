package de.rwth.idsg.steve.web.controller.rest;

import de.rwth.idsg.steve.ocpp.CommunicationTask;
import de.rwth.idsg.steve.ocpp.OcppTransport;
import de.rwth.idsg.steve.repository.TaskStore;
import de.rwth.idsg.steve.repository.dto.ChargePointSelect;
import de.rwth.idsg.steve.service.ChargePointService16_Client;
import de.rwth.idsg.steve.web.dto.ocpp.ChangeAvailabilityParams;
import de.rwth.idsg.steve.web.dto.ocpp.MultipleChargePointSelect;
import de.rwth.idsg.steve.web.dto.rest.ChangeAvailabilityRequest;
import de.rwth.idsg.steve.web.dto.rest.CreateTaskRequest;
import de.rwth.idsg.steve.web.dto.rest.TaskDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import static de.rwth.idsg.steve.web.dto.rest.CreateTaskRequest.TaskType.CHANGE_AVAILABILITY;


@RestController
@RequestMapping("/api/tasks")
public class TaskRestController {
    @Autowired
    @Qualifier("ChargePointService16_Client")
    private ChargePointService16_Client client16;

    @Autowired
    private TaskStore taskStore;

    private Map<CreateTaskRequest.TaskType, Function<CreateTaskRequest, Integer>> taskProcessors = new HashMap<>();
    {
        taskProcessors.put(CHANGE_AVAILABILITY, this::changeAvailability);
    }

    @PostMapping
    public ResponseEntity<Integer> createTask(@RequestBody CreateTaskRequest request) {

        final Function<CreateTaskRequest, Integer> processor = taskProcessors.get(request.getType());

        if (processor != null) {
            return ResponseEntity.ok(processor.apply(request));
        }

        return new ResponseEntity(HttpStatus.NOT_IMPLEMENTED);
    }

    @GetMapping("/{taskId}")
    public ResponseEntity<TaskDetail> getTask(@PathVariable int taskId) {
        final CommunicationTask task = taskStore.get(taskId);

        return ResponseEntity.ok(TaskDetail.builder()
                .operationName(task.getOperationName())
                .resultMap(task.getResultMap())
                .startDate(task.getStartTimestamp())
                .endDate(task.getEndTimestamp())
                .errorCount(task.getErrorCount().get())
                .responseCount(task.getErrorCount().get())
                .build());
    }

    private void fillChargePoint(CreateTaskRequest request, MultipleChargePointSelect params) {
        params.setChargePointSelectList(Collections.singletonList(
                new ChargePointSelect(OcppTransport.JSON, request.getChargeBoxId())));
    }

    private Integer changeAvailability(CreateTaskRequest request) {
        final ChangeAvailabilityRequest changeAvailability = request.getChangeAvailability();
        final ChangeAvailabilityParams params = new ChangeAvailabilityParams();

        Assert.notNull(changeAvailability, "Required parameter changeAvailability missing.");

        params.setConnectorId(request.getConnectorId());
        params.setAvailType(changeAvailability.getAvailType());
        fillChargePoint(request, params);

        return client16.changeAvailability(params);
    }
}
