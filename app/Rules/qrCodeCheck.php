<?php

namespace App\Rules;

use App\Models\ItemQr;
use Illuminate\Contracts\Validation\Rule;

class qrCodeCheck implements Rule
{
    /**
     * Create a new rule instance.
     *
     * @return void
     */
    public function __construct()
    { }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        $arr = explode('-', $value);
        $start = reset($arr);
        if (count($arr) > 2) {
            $sliced = array_slice($arr, 0, -1);
            $start = implode('-', $sliced);
        }
        return ItemQr::where(['id' => end($arr), 'unique_value' => $start])->exists();
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'The given qr code is not found.';
    }
}
