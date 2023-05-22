<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'is_user'];

    protected $hidden = [
        'id',
        'is_user',
        'created_at',
        'updated_at'
    ];

    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'permission_role');
    }

    public function panels()
    {
        return $this->belongsToMany(Panel::class, 'panel_role');
    }

    public function departments()
    {
        return $this->belongsToMany(Department::class, 'department_role')->select('id', 'title');
    }

    public function setNameAttribute($value)
    {
        $this->attributes['name'] = strtolower($value);
    }

    public function getNameAttribute($value)
    {
        return ucfirst($value);
    }

    public function allow($permissions)
    {
        $this->permissions()->syncWithoutDetaching($permissions);
    }

    public function deny($permissions)
    {
        $this->permissions()->detach($permissions);
    }
}
