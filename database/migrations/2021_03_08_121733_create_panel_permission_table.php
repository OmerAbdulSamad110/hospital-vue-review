<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePanelPermissionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('panel_permission', function (Blueprint $table) {
            $table->primary(['panel_id', 'permission_id']);
            $table->unsignedBigInteger('panel_id');
            $table->unsignedBigInteger('permission_id');

            $table->foreign('panel_id')->references('id')
                ->on('panels')->onDelete('cascade');
            $table->foreign('permission_id')->references('id')
                ->on('permissions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('panel_permission');
    }
}
