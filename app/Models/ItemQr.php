<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ItemQr extends Model
{
    use HasFactory;
    protected $fillable = ['assigned_date', 'unique_value', 'assignor_id', 'assignee_id', 'item_id', 'department_id', 'supplier_id', 'factory_id', 'purchased_at'];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }

    public function supplier()
    {
        return $this->belongsTo(Supplier::class);
    }

    public function assignor()
    {
        return $this->belongsTo(Employee::class);
    }
    public function assignee()
    {
        return $this->belongsTo(Employee::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }

    public function factory()
    {
        return $this->belongsTo(Factory::class);
    }
}
