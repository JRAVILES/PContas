<?php 

class Vpconta extends \Eloquent {

	
        protected $table = 'vpcontas';

        // Add your validation rules here
	public static $rules = [
		 'codigo' => 'required',
		 'descricao' => 'required'
	];

        public static $nice_names = array(
		 'codigo' => 'Código',
		 'descricao' => 'Descrição'
        );
	
        // Don't forget to fill this array
	protected $fillable = [];
        
        
    public function getCodcompletoAttribute($value) {
        $codigos = json_decode($this->attributes['codcompleto']);
        $tipo = $this->attributes['tipo'];
        $codigofinal = '';
        $indice = 0;
        $separador = '';

        end($codigos);
        $lastKey = key($codigos);
        foreach ($codigos as $k => $codigo) {
            if ($indice > 0) {
                $separador = '.';
            }
            $indice++;
            if ($tipo == 'A' && $k == $lastKey) {
                $codigofinal = $codigofinal . $separador . Utilitarios::direita('00000' . $codigo, 5);
            } else {
                $codigofinal = $codigofinal . $separador . $codigo;
            }
        }
        return $codigofinal;
        
        
    }
    
    public function getDsctipoAttribute($value) {
        return ($this->attributes['tipo'] == 'A') ? 'Analítica' : 'Sintética';
    }
        
}