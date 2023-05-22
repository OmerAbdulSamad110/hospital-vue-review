<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDepartmentRoleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('department_role', function (Blueprint $table) {
            $table->primary(['department_id', 'role_id']);
            $table->unsignedBigInteger('department_id');
            $table->unsignedBigInteger('role_id');

            $table->foreign('department_id')->references('id')
                ->on('departments')->onDelete('cascade');
            $table->foreign('role_id')->references('id')
                ->on('roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('department_role');
    }
}
