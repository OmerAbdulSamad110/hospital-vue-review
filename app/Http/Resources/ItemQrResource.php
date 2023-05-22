<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Resources\Json\JsonResource;

class ItemQrResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'unique_value' => $this->unique_value,
            'purchased_at' => Carbon::parse($this->purchased_at)->format('d-m-Y'),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'item' => $this->relationLoaded('item') ? new ItemResource($this->whenLoaded('item')) : $this->item_id,
            'supplier' => new SupplierResource($this->whenLoaded('supplier')),
            'department' => new DepartmentResource($this->whenLoaded('department')),
            'assign_info' => !isset($this->assignee_id) && !isset($this->assignor_id) ?
                null : [
                    'assigned_date' => Carbon::parse($this->assigned_date)->format('d-m-Y h:i A'),
                    'assignor' => new EmployeeResource($this->whenLoaded('assignor')),
                    'assignee' => new EmployeeResource($this->whenLoaded('assignee')),
                ],
        ];
    }
}
