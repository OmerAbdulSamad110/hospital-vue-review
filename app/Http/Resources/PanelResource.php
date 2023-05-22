<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PanelResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        $arr = [
            'id' => $this->when(!is_null($this->id), $this->id),
            'title' => $this->title,
            'url' => $this->when(!is_null($this->slug), $this->slug),
            'permissions' => SimplePermissionResource::collection($this->whenLoaded('permissions')),
        ];
        // if (!!$this->permissions) {
        // To get linear array of required key from a hierarchical array of collections
        //     $arr['available'] = $this->permissions->each->children->pipe(function ($c) {
        //         $array = $c->toArray();
        //         $ids = [];
        //         array_walk_recursive($array, function ($value, $key) use (&$ids) {
        //             if ($key === 'id') {
        //                 $ids[] = $value;
        //             }
        //         });
        //         return $ids;
        //     });
        // }
        return $arr;
    }
}
