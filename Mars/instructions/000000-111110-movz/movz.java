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


public class movz extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {

        int[] operands = statement.getOperands();
        int v1 = RegisterFile.getValue(operands[1]);
        int v2 = RegisterFile.getValue(operands[2]);
        if (v2 > 0){
            RegisterFile.updateRegister(operands[0], v1);
            return;
        } else {
            return;
        }
    }

    @Override
    public String getExample() {
        return "movz $t1,$t2,$t3";
    }

    @Override
    public String getDescription() {
        return "movz";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.R_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "000000 sssss ttttt fffff 00000 111110";
    }
}
