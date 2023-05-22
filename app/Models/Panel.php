<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Panel extends Model
{
    use HasFactory;
    protected $fillable = ['title', 'slug'];
    protected $hidden = ['pivot'];

    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'panel_permission')->orderBy('permissions.id');
    }
}
