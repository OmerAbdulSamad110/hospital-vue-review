<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MedicineInventoryRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return auth()->check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $arr = [];
        $append = !!$this->route('inventory') ? ",{$this->route('inventory')}" : '';
        if (!$this->has("status") || $this->status != "revert") {
            $arr = [
                'patch_no' => 'required|string|max:255|unique:medicine_inventories,patch_no' . $append,
                'quantity' => 'required|integer|min:1',
                'produced_at' => 'required|date',
                'expired_at' => 'required|date|after:produced_at',
                'medicine' => 'required|integer|exists:medicines,id,status,1'
            ];
        }
        return $arr;
    }
}
