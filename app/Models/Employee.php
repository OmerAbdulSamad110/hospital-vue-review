<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;
    protected $fillable = [
        'picture',
        'name',
        'number',
        'email',
        'phone',
        'gender',
        'department_id',
        'role_id',
    ];

    public function account()
    {
        return $this->hasOne(Account::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }

    public function role()
    {
        return $this->belongsTo(Role::class);
    }

    public function getStatusAttribute()
    {
        return $this->account()->status;
    }
}
