import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class lhogez extends BranchOperation implements AdditionalInstruction {

    private boolean OneIsMore(int value1) {
        int count = 0;
        for(int i=0;i<16;i++){
            if((value1 & (1<<i))!=0){
                count++;
            }
        }
        if(count>8) return true;
        else return false;
    }
    

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {

        int[] operands = statement.getOperands();
        try
        {
            if(OneIsMore(Globals.memory.getHalf(
                    RegisterFile.getValue(operands[2])
                            + (operands[1] << 16 >> 16))
                                    << 16
                                    >>> 16)){
                RegisterFile.updateRegister(
                    operands[0],
                    Globals.memory.getHalf(
                    RegisterFile.getValue(operands[2])
                            + (operands[1] << 16 >> 16))
                                    << 16
                                    >>> 16);
            }else{
                processReturnAddress(31);
            }
        } 
            catch (AddressErrorException e)
        {
            throw new ProcessingException(statement, e);
        }

    }

    @Override
    public String getExample() {
        return "lhogez $t1,-100($t2)";
    }

    @Override
    public String getDescription() {
        return "lhogez";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.I_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111011 fffff sssss tttttttttttttttt";
    }
}
