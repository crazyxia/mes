/**
 * ***************************************************************************
 * Copyright (c) 2010 Qcadoo Limited
 * Project: Qcadoo MES
 * Version: 1.3
 *
 * This file is part of Qcadoo.
 *
 * Qcadoo is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation; either version 3 of the License,
 * or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * ***************************************************************************
 */
package com.qcadoo.mes.workPlans.listeners;

import com.google.common.collect.Lists;
import com.qcadoo.mes.technologies.constants.TechnologyOperationComponentFields;
import com.qcadoo.mes.workPlans.constants.OperationFieldsWP;
import com.qcadoo.model.api.Entity;
import com.qcadoo.view.api.ComponentState;
import com.qcadoo.view.api.ViewDefinitionState;
import com.qcadoo.view.api.components.FieldComponent;
import com.qcadoo.view.api.components.LookupComponent;
import org.springframework.stereotype.Service;

@Service
public class TechnologyOperationComponentDetailsListenersWP {

    public final void setTechnologyOperationComponentDefaultValues(final ViewDefinitionState view,
            final ComponentState component, final String[] args) {
        LookupComponent operationLookup = (LookupComponent) view
                .getComponentByReference(TechnologyOperationComponentFields.OPERATION);

        if (operationLookup.getEntity() != null) {
            Entity operation = operationLookup.getEntity();

            for (String fieldName : Lists.newArrayList(OperationFieldsWP.HIDE_DESCRIPTION_IN_WORK_PLANS,
                    OperationFieldsWP.HIDE_DETAILS_IN_WORK_PLANS, OperationFieldsWP.HIDE_TECHNOLOGY_AND_ORDER_IN_WORK_PLANS,
                    OperationFieldsWP.IMAGE_URL_IN_WORK_PLAN, OperationFieldsWP.DONT_PRINT_INPUT_PRODUCTS_IN_WORK_PLANS,
                    OperationFieldsWP.DONT_PRINT_OUTPUT_PRODUCTS_IN_WORK_PLANS)) {
                FieldComponent fieldComponent = (FieldComponent) view.getComponentByReference(fieldName);
                fieldComponent.setFieldValue(getOperationField(operation, fieldName));
            }
        }
    }

    private Object getOperationField(final Entity operation, final String fieldName) {
        if ((operation == null) || (operation.getField(fieldName) == null)) {
            return null;
        } else {
            return operation.getField(fieldName);
        }
    }

}
