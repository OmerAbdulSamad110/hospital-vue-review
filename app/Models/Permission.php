<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{
    use HasFactory;
    protected $fillable = ['title', 'slug', 'module', 'panel_id'];
    protected $hidden = ['pivot'];

    public $timestamps = false;

    public function role()
    {
        return $this->belongsToMany(Role::class, 'permission_role');
    }

    public function children()
    {
        return $this->hasMany(Permission::class, 'parent_id', 'id')->with('children');
    }

    public function panels()
    {
        return $this->belongsToMany(Panel::class, 'panel_permission');
    }
}
