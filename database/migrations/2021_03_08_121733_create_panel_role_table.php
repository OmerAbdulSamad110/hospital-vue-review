<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePanelRoleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('panel_role', function (Blueprint $table) {
            $table->primary(['panel_id', 'role_id']);
            $table->unsignedBigInteger('panel_id');
            $table->unsignedBigInteger('role_id');
            $table->timestamps();

            $table->foreign('panel_id')->references('id')->on('panels')->onDelete('cascade');
            $table->foreign('role_id')->references('id')->on('roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('panel_role');
    }
}
