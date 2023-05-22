<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'description', 'sub_category_id', 'factory_id', 'status'];
    protected $casts = [
        'status' => 'boolean'
    ];


    public function scopeWithAndWhereHas($query, $relation, $callback)
    {
        return $query->whereHas($relation, $callback)->with([$relation => $callback]);
    }


    public function scopeDepartWise($query, $id)
    {
        // $query->whereHas('subCategory.category.department', function ($q) use ($id) {
        //     $q->where('id', $id);
        // })->with(['subCategory.category.department' => function ($q) use ($id) {
        //     $q->where('id', $id);
        // }]);
    }

    public function suppliers()
    {
        return $this->belongsToMany(Supplier::class);
    }

    public function subCategory()
    {
        return $this->belongsTo(SubCategory::class);
    }

    public function qrs()
    {
        return $this->hasMany(ItemQr::class)->latest();
    }

    public function factory()
    {
        return $this->belongsTo(Factory::class)->select('id', 'name');
    }

    public function generateQrs($data)
    {
        $qrs = [];
        foreach ($data['unique_values'] as $unique_value) {
            $qrs[] = [
                'department_id' => $data['department'],
                'supplier_id' => $data['supplier'],
                'unique_value' => $unique_value,
                'purchased_at' => $data['purchased_at']
            ];
        }
        return $this->qrs()->createMany($qrs);
    }
}
